import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {Location} from "@angular/common";


@Injectable({
  providedIn: 'root'
})
export class PackageService {
  BACKEND_URL = environment.apiUrl + 'package/';
  constructor(
    private http: HttpClient,
    private router: Router,
    private location: Location,
  ) {
  }

  getPackageAddContext(){
    return  this.http.get<any>(this.BACKEND_URL+'context/',);
  }


  getPackageList(limit=10,offset=0, queryParamsDict: { [key: string]: any } ){
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

  getPackage(id:number){
    return  this.http.get<any>(this.BACKEND_URL+`${id}/`);
  }

  addNewPackage(formData:FormData,){
    return this.http.post<any>(this.BACKEND_URL,formData);
  }
  updatePackage(formData:FormData,id:number){
    return this.http.put<any>(this.BACKEND_URL+`${id}/`,formData);
  }




}
