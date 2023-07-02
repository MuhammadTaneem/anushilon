import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {DashboardComponent} from "./dashboard/dashboard.component";
import {LayoutComponent} from "./layout/layout.component";

const routes: Routes = [
  {
    path: '',
    // pathMatch: 'full',
    component: LayoutComponent,
    children: [
      {
        path: '',
        pathMatch: 'full',
        redirectTo: 'offer',
      },
      {
        path: 'dashboard',
        component:DashboardComponent,
        // loadChildren: () => import('./dashboard/dashboard.module').then((m) => m.DashboardModule ),
      },
      {
        path: 'mcq',
        loadChildren: () => import('./mcq/mcq.module').then((m) => m.McqModule ),
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

  // {path: '**', redirectTo: 'dashboard'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
