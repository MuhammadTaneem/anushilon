import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomepageComponent } from './homepage/homepage.component';
import {AppbarComponent} from "./homepage/appbar/appbar.component";
import {FooterComponent} from "./homepage/footer/footer.component";
import {DashboardModule} from "./dashboard/dashboard.module";
import {McqModule} from "./mcq/mcq.module";
import {AuthModule} from "./auth/auth.module";
import {MaterialModule} from "./material/material.module";
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {HTTP_INTERCEPTORS, HttpClientModule} from "@angular/common/http";
import {AuthInterceptor} from "./auth/auth.interceptor";
import {ExamModule} from "./exam/exam.module";
import {CouponModule} from "./coupon/coupon.module";
import { QuestionBankComponent } from './question-bank/question-bank.component';

@NgModule({
  declarations: [
    AppComponent,
    HomepageComponent,
    AppbarComponent,
    FooterComponent,
    QuestionBankComponent,


  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    DashboardModule,
    McqModule,
    AuthModule,
    MaterialModule,
    ExamModule,
    CouponModule,
    BrowserAnimationsModule,
    HttpClientModule,
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
