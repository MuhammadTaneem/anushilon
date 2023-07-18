import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {authGuard} from "../auth/auth.guard";
import {PackageComponent} from "./package.component";
import {PackageAddComponent} from "./package-add/package-add.component";
import {PackageDetailsComponent} from "./package-details/package-details.component";

const routes: Routes = [
  {
    path:'',
    canActivate: [authGuard],
    component:PackageComponent
  },
  {
    path:'add',
    canActivate: [authGuard],
    component:PackageAddComponent
  },
  {
    path:'details/:id',
    canActivate: [authGuard],
    component:PackageDetailsComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PackageRoutingModule { }
