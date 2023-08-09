import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {DashboardComponent} from "./dashboard/dashboard.component";
import {HomepageComponent} from "./homepage/homepage.component";
import {authGuard} from "./auth/auth.guard";

const routes: Routes = [
  {
    path: '',
    component: HomepageComponent,
    children: [
      {
        path: '',
        pathMatch: 'full',
        redirectTo: 'dashboard',
      },
      {
        path: 'dashboard',
        canActivate: [authGuard],
        loadChildren: () => import('./dashboard/dashboard.module').then((m) => m.DashboardModule),

      },
      {
        path: 'mcq',
        canActivate: [authGuard],
        loadChildren: () => import('./mcq/mcq.module').then((m) => m.McqModule),
      },{
        path: 'package',
        canActivate: [authGuard],
        loadChildren: () => import('./package/package.module').then((m) => m.PackageModule),
      },{
        path: 'exam',
        canActivate: [authGuard],
        loadChildren: () => import('./exam/exam.module').then((m) => m.ExamModule),
      },{
        path: 'coupon',
        canActivate: [authGuard],
        loadChildren: () => import('./coupon/coupon.module').then((m) => m.CouponModule),
      },
      {
        path: 'question_bank',
        canActivate: [authGuard],
        loadChildren: () => import('./question-bank/question-bank.module').then((m) => m.QuestionBankModule),
      },

    ]
  },
  {
    path: 'auth',
    loadChildren: () => import('./auth/auth.module').then((m) => m.AuthModule),
    // outlet: 'main'

  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
