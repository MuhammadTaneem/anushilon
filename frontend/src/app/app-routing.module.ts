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
      },
      // {
      //   path: 'exam',
      //   component: ExamComponent,
      // },
      // {
      //   path: 'offer',
      //   component: OfferComponent,
      // },
      // {
      //   path: 'package',
      //   component: PackageComponent,
      // },
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
