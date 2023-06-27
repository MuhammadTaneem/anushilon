import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { McqRoutingModule } from './mcq-routing.module';
import { McqComponent } from './mcq.component';
import { McqAddComponent } from './mcq-add/mcq-add.component';


@NgModule({
  declarations: [
    McqComponent,
    McqAddComponent
  ],
  imports: [
    CommonModule,
    McqRoutingModule
  ]
})
export class McqModule { }
