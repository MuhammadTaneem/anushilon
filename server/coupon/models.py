from django.db import models
from custom_user.models import CustomUser
from package.models import Package


class Coupon(models.Model):
    coupon_text = models.CharField(max_length=1023, null=False, blank=False)
    coupon_start_date = models.DateTimeField(null=False, blank=False)
    coupon_end_date = models.DateTimeField(null=False, blank=False)
    creator = models.ForeignKey(CustomUser, on_delete=models.DO_NOTHING, null=False, blank=False)
    packages = models.ManyToManyField(Package)
    published = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    @property
    def creator_name(self):
        if self.creator:
            return self.creator.full_name
        return None

    def packages_list(self):
        related_objects = self.packages.all()
        related_values = related_objects.values()
        return related_values
