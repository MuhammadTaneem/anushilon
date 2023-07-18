import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { McqRoutingModule } from './mcq-routing.module';
import { McqComponent } from './mcq.component';
import {MaterialModule} from "../material/material.module";
import { McqAddComponent } from './mcq-add/mcq-add.component';
import { MaqDetailsComponent } from './mac-details/maq-details.component';


@NgModule({
  declarations: [
    McqComponent,
    McqAddComponent,
    MaqDetailsComponent
  ],
  imports: [
    CommonModule,
    McqRoutingModule,
    MaterialModule,
  ]
})
export class McqModule { }
