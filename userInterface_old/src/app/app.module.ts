import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {AuthModule} from "./auth/auth.module";
import {MaterialModule} from "./material/material.module";
import {HttpClientModule} from "@angular/common/http";
import {HomepageComponent} from "./dashboard/homepage/homepage.component";
import {DashboardComponent} from "./dashboard/dashboard.component";
import {FooterComponent} from "./dashboard/footer/footer.component";
import {AppbarComponent} from "./dashboard/appbar/appbar.component";


@NgModule({
  declarations: [
    AppComponent,
    HomepageComponent,
    DashboardComponent,
    FooterComponent,
    AppbarComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule,
    AuthModule,
    HttpClientModule,
    MaterialModule,


  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
