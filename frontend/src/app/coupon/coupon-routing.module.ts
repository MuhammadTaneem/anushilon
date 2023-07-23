import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {authGuard} from "../auth/auth.guard";
import {CouponComponent} from "./coupon.component";
import {CouponAddComponent} from "./coupon-add/coupon-add.component";
import {CouponDetailsComponent} from "./coupon-details/coupon-details.component";

const routes: Routes = [
  {
    path:'',
    canActivate: [authGuard],
    component:CouponComponent
  },
  {
    path:'add',
    canActivate: [authGuard],
    component:CouponAddComponent
  },
  {
    path:'details/:id',
    canActivate: [authGuard],
    component:CouponDetailsComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CouponRoutingModule { }
