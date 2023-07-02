import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { McqRoutingModule } from './mcq-routing.module';
import { McqComponent } from './mcq.component';
import {MaterialModule} from "../material/material.module";


@NgModule({
  declarations: [
    McqComponent
  ],
  imports: [
    CommonModule,
    McqRoutingModule,
    MaterialModule
  ]
})
export class McqModule { }
