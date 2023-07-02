import {Injectable} from '@angular/core';
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
  BACKEND_URL = environment.apiUrl + 'admin/';
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

  login(email: string, password: string) {
    this.http.post<any>(this.BACKEND_URL + 'login/', {
      email, password
    }).subscribe({
      next: (loginData) => {
        console.log(loginData.status);
        console.log(loginData.message);
        console.log(loginData.user.id);
        console.log(loginData.user.email);
        console.log(loginData.user.token);
        console.log(loginData.user.expire);
      },
      error: (err) => {
        console.log(err.status_code);
        console.log(err.error);
        console.log(err.error.status);
        console.log(err.error.errors);
        console.log(err.error.message);
      },
      complete: () => {
      }
    });
  }

  // login(email: string, password: string) {
  //   this.http
  //     .post<any>(
  //       this.BACKEND_URL + 'login/',
  //       {
  //         email,
  //         password,
  //       }
  //     )
  //     .subscribe(
  //
  //       (loginData) => {
  //         if (loginData.access) {
  //           this.snacbar.open('login success ', 'X', {duration: 2000});
  //
  //           const now = new Date();
  //           const expirationDate = new Date(
  //             now.getTime() + this.tokenTimeDuration * 1000
  //           );
  //
  //           this.Loading.next(false);
  //           localStorage.setItem('token', loginData.access);
  //           // localStorage.setItem('uid', loginData.user.id);
  //           localStorage.setItem('expiration', expirationDate.toISOString());
  //           console.log(loginData.access);
  //           this.loadId(loginData.access);
  //
  //           // this.loadMe();
  //         }
  //       },
  //       (error) => {
  //         this.Loading.next(false);
  //         let err = JSON.stringify(error.error);
  //         err = err.split(':')[1];
  //         // err = err.slice(2, -4);
  //         // this.snacbar.open(err, 'X');
  //       },
  //       ()=>{}
  //     ):Subscription;
  // }


}
