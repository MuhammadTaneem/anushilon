import {CanActivateFn, Router} from '@angular/router';
import {AuthService} from "./auth.service";
import {inject} from "@angular/core";

export const authGuard: CanActivateFn = (route, state) => {
  const authService = inject(AuthService);
  const router = inject(Router);

  if (authService.isAuthenticated()) {




    if (authService.isProblemSetter() &&(state.url === '/mcq' || state.url === '/mcq/add')) {
      return true; // Allow access to the requested route
    }else if(authService.isProblemSetter() &&!(state.url === '/mcq' || state.url === '/mcq/add')) {
      router.navigate(['/mcq']);
      return  false;
    }
    else{
      return true;
    }
  } else {
    router.navigate(['/auth/login']);
    return false; // Prevent access to the requested route
  }
};
