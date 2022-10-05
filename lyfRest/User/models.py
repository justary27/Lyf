import uuid
from django.db import models
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager


# Create your models here.

class LyfUserManager(BaseUserManager, models.Manager):

    def create_superuser(self, email, username, password, **other_fields):

        other_fields.setdefault('is_staff', True)
        other_fields.setdefault('is_admin', True)
        other_fields.setdefault('is_superuser', True)
        other_fields.setdefault('is_active', True)

        if other_fields.get('is_staff') is not True:
            raise ValueError(
                'Superuser must be assigned to is_staff=True.')
        if other_fields.get('is_superuser') is not True:
            raise ValueError(
                'Superuser must be assigned to is_superuser=True.')

        return self.create_user(email, username, password, **other_fields)

    def create_user(self, email, username, password, **other_fields):

        if not email:
            raise ValueError(_('You must provide an email address'))

        else:
            email = self.normalize_email(email)
            user = self.model(
                email=email,
                username=username,
                **other_fields
            )
            user.set_password(password)
            user.save()

            return user

    def login_user(self, email, password):
        return self.filter(email=email,
                           password=password
                           ).get()

    def get_user_by_id(self, userId: str):
        return self.filter(_id=userId).get()


def user_directory_path(instance, filename):
    return '{0}/pfp/{1}'.format(instance._id, filename)


class LyfUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(
        _("Email Address"),
        unique=True,
    )
    username = models.CharField(
        _("Username"),
        max_length=80,
        unique=True,
    )
    _id = models.UUIDField(
        default=uuid.uuid4,
        auto_created=True,
        primary_key=True,
        editable=False,
        unique=True,
    )
    _pfp = models.ImageField(_("Profile Picture"), upload_to=user_directory_path)

    _start_date = models.DateTimeField(default=timezone.now, editable=False, auto_created=True)
    _is_proUser = models.BooleanField(default=False)

    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)

    is_active = models.BooleanField(default=True)

    USERNAME_FIELD = 'email'

    REQUIRED_FIELDS = [
        'username',
    ]

    objects = LyfUserManager()

    @property
    def userEmail(self):
        return self.email

    @property
    def userName(self):
        return self.username

    @property
    def isProUser(self):
        return self._is_proUser

    @property
    def asDict(self):
        return {
            "username": self.userName,
        }

    def __str__(self) -> str:
        return self.username


from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)
