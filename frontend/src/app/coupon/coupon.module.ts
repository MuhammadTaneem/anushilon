import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CouponRoutingModule } from './coupon-routing.module';
import {CouponComponent} from "./coupon.component";
import {CouponDetailsComponent} from "./coupon-details/coupon-details.component";
import {CouponAddComponent} from "./coupon-add/coupon-add.component";
import {MatButtonModule} from "@angular/material/button";
import {MatIconModule} from "@angular/material/icon";
import {CdkDrag, CdkDropList, CdkDropListGroup} from "@angular/cdk/drag-drop";
import {MatCheckboxModule} from "@angular/material/checkbox";
import {MatDatepickerModule} from "@angular/material/datepicker";
import {MatExpansionModule} from "@angular/material/expansion";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInputModule} from "@angular/material/input";
import {MatOptionModule} from "@angular/material/core";
import {MatPaginatorModule} from "@angular/material/paginator";
import {MatSelectModule} from "@angular/material/select";
import {MatStepperModule} from "@angular/material/stepper";
import {MaterialModule} from "../material/material.module";
import {ReactiveFormsModule} from "@angular/forms";


@NgModule({
  declarations: [
    CouponComponent,
    CouponDetailsComponent,
    CouponAddComponent,
  ],
  imports: [
    CommonModule,
    CouponRoutingModule,
    MatButtonModule,
    MatIconModule,
    CdkDrag,
    CdkDropList,
    CdkDropListGroup,
    MatCheckboxModule,
    MatDatepickerModule,
    MatExpansionModule,
    MatFormFieldModule,
    MatInputModule,
    MatOptionModule,
    MatPaginatorModule,
    MatSelectModule,
    MatStepperModule,
    MaterialModule,
    ReactiveFormsModule
  ]
})
export class CouponModule { }
