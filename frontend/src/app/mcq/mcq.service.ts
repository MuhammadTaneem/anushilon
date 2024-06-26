import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {Location} from "@angular/common";
import {environment} from "../../environments/environment";

@Injectable({
  providedIn: 'root'
})
export class McqService {

  BACKEND_URL = environment.apiUrl + 'mcq/';

  constructor(
    private http: HttpClient,
    private router: Router,
    private location: Location,
  ) {
  }


  getMcqAddContext(){
   return  this.http.get<any>(this.BACKEND_URL+'context/',);
  }

  getMcqList(limit=10,offset=0, queryParamsDict: { [key: string]: any } ){
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

  getMcq(id:number){
    return  this.http.get<any>(this.BACKEND_URL+`${id}/`);
  }

  addNewMcq(formData:FormData,){
    return this.http.post<any>(this.BACKEND_URL,formData);
  }
  updateMcq(formData:FormData,id:number){
    return this.http.put<any>(this.BACKEND_URL+`${id}/`,formData);
  }
}
