import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Router} from "@angular/router";
import {Location} from "@angular/common";

@Injectable({
  providedIn: 'root'
})
export class CouponService {

  BACKEND_URL = environment.apiUrl + 'coupon/';

  constructor(
    private http: HttpClient,
    private router: Router,
    private location: Location,
  ) {
  }


  getCouponAddContext(){
    return  this.http.get<any>(this.BACKEND_URL+'context/',);
  }

  getCouponList(limit=10,offset=0, queryParamsDict: { [key: string]: any } ){
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

  getCoupon(id:number){
    return  this.http.get<any>(this.BACKEND_URL+`${id}/`);
  }

  addNewCoupon(formData:any,){
    return this.http.post<any>(this.BACKEND_URL,formData);
  }
  updateCoupon(formData:any,id:number){
    return this.http.put<any>(this.BACKEND_URL+`${id}/`,formData);
  }
}
