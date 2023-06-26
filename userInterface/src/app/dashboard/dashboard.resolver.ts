import { ResolveFn } from '@angular/router';

export const dashboardResolver: ResolveFn<boolean> = (route, state) => {
  return true;
};
