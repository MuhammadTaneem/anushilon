import { Injectable } from '@angular/core';
import {environment} from "../../environments/environment";
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Subject, Subscription} from 'rxjs';
import {MatSnackBar} from '@angular/material/snack-bar';
import {Router} from '@angular/router';
import {Location} from '@angular/common';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  BACKEND_URL = environment.apiUrl + 'auth/';
  isAuthenticated = false;
  uid!: any;
  token!: any;
  tokenTimer: any;
  haveToken = new Subject<boolean>();
  Loading = new Subject<boolean>();
  created = new Subject<boolean>();
  tokenTimeDuration = 60 * 60 * 24 * 30;
  redirectUrl: string | null = '';

  constructor(
    private http: HttpClient,
    private router: Router,
    private location: Location,
  ) {
  }
  login(email:string, password: string){
    this.http.post<any>(this.BACKEND_URL+'login/',{
      email, password
    }).subscribe({
      next: (loginData)=>{
        console.log(loginData);

        localStorage.setItem('uid', loginData.id);
        localStorage.setItem('email', loginData.email);
        localStorage.setItem('token', loginData.token);
        localStorage.setItem('role', loginData.role);
        this.router.navigate(['/']);
      },
      error: (err)=>{
        console.log(err);
        console.log(err.status_code);
        console.log(err.error);
        console.log(err.error.status);
        console.log(err.error.errors);
        console.log(err.error.message);
      },
      complete:()=>{}
    });
  }

  getToken() {
    return localStorage.getItem('token');
  }
}
