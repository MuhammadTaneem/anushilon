import { NgModule } from '@angular/core';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';

import { AuthRoutingModule } from './auth-routing.module';
import {LoginComponent} from "./login/login.component";
import {MaterialModule} from "../material/material.module";



@NgModule({
  declarations: [
    LoginComponent,
  ],
  imports: [
    ReactiveFormsModule,
    FormsModule,
    MaterialModule,

    AuthRoutingModule,

  ],
  // exports:[
  //   LoginComponent,
  //   FormsModule,
  //   ReactiveFormsModule,
  // ]
})
export class AuthModule { }
