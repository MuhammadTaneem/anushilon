import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {Location} from "@angular/common";

@Injectable({
  providedIn: 'root'
})
export class ExamService {

  BACKEND_URL = environment.apiUrl + 'exam/';

  constructor(
    private http: HttpClient,
    private router: Router,
    private location: Location,
  ) {
  }


  getExamAddContext(){
    return  this.http.get<any>(this.BACKEND_URL+'context/',);
  }

  getExamList(limit=10,offset=0, queryParamsDict: { [key: string]: any } ){
    let url =this.BACKEND_URL+`?limit=${limit}&offset=${offset}`;
    if (queryParamsDict) {
      for (const key in queryParamsDict) {
        if (queryParamsDict.hasOwnProperty(key)) {
          const value = queryParamsDict[key];
          url += `&${key}=${value}`;
        }
      }
    }
    return  this.http.get<any>(url);
  }

  getExam(id:number){
    return  this.http.get<any>(this.BACKEND_URL+`${id}/`);
  }

  addNewExam(formData:any,){
    return this.http.post<any>(this.BACKEND_URL,formData);
  }
  updateExam(formData:any,id:number){
    return this.http.put<any>(this.BACKEND_URL+`${id}/`,formData);
  }
}
