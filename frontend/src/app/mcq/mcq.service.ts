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

  addNewMcq(formData:any){
    return this.http.post<any>(this.BACKEND_URL,{form:formData});
  }
}
