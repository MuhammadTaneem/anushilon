import {NgModule} from '@angular/core';


import {AuthRoutingModule} from './auth-routing.module';
import {LoginComponent} from "./login/login.component";
import {MaterialModule} from "../material/material.module";
import {ReactiveFormsModule} from "@angular/forms";


@NgModule({
  declarations: [
    LoginComponent,
  ],
  imports: [
    MaterialModule,
    AuthRoutingModule,
    ReactiveFormsModule,

  ],
  // exports:[
  //   LoginComponent,
  //   FormsModule,
  //   ReactiveFormsModule,
  // ]
})
export class AuthModule {
}
