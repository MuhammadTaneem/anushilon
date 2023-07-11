import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import { Observable } from 'rxjs';
import {AuthService} from "./auth.service";

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  private excludedRoutes: RegExp[] = [
    // /\/admin\/login\/$/,
    // /\/admin\/signin\/$/,
    /auth/,
    /context/,
    /\/context\/$/, // Route pattern with dynamic parameter
  ];

  is_free(url:string){
    return this.excludedRoutes.some(route => route.test(url));
  }

  constructor(private  authService: AuthService) {}

  intercept(request: HttpRequest<unknown>, next: HttpHandler):
    Observable<HttpEvent<unknown>> {
    console.log('header  added');


    const auth_token = this.authService.getToken();

    if (!this.is_free(request.url)) {
      request = request.clone({
        setHeaders: {
          Authorization: `Token ${auth_token}`
        },
      });
    }

      // 'Content-Type': request.body instanceof FormData ? 'multipart/form-data': 'application/json'
    // 'Content-Type': 'multipart/form-data'
    // else{
    //   request = request.clone({
    //     setHeaders: {
    //       // 'Content-Type': request.body instanceof FormData ? 'multipart/form-data': 'application/json'
    //     },
    //   });
    // }

    return next.handle(request);
  }
}
