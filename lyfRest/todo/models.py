from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
import uuid
from User.models import LyfUser


# Create your models here.
class TodoManger(models.Manager):

    def getTodos(self, user_id):
        return list(self.filter(_user=LyfUser.objects.get_user_by_id(user_id)
                                ).all())

    def get_todo_by_id(self, todo_id):
        return self.filter(_id=todo_id).get()


class Todo(models.Model):

    _id = models.UUIDField(
        default=uuid.uuid4,
        auto_created=True,
        primary_key=True,
        editable=False,
        unique=True,
    )
    _user = models.ForeignKey(LyfUser, on_delete=models.CASCADE, editable=False)

    _title = models.CharField(
        _("Title"),
        max_length=120,
        default="Untitled"
    )
    _description = models.CharField(
        _("Description"),
        max_length=2048,
    )

    _created_on = models.DateTimeField(default=timezone.now)
    _is_reminder_set = models.BooleanField(_("isReminderSet"), default=False, editable=False)
    _reminder_at = models.DateTimeField(null=True, blank=True)

    objects = TodoManger()

    @property
    def id(self) -> str:
        return str(self._id)

    @property
    def title(self) -> str:
        return self._title

    @property
    def description(self) -> str:
        return self._description

    @property
    def created_at(self) -> str:
        return str(self._created_on)

    @property
    def isReminderset(self) -> bool:
        return self._is_reminder_set

    @property
    def ReminderAt(self) -> str:
        return str(self._reminder_at)

    @property
    def as_dict(self) -> dict:
        return {
            "_id": self.id,
            "_title": self.title,
            "_description": self.description,
            "_createdAt": self.created_at,
            "_isReminderSet": self.isReminderset,
            "_reminderAt": self.ReminderAt if self.ReminderAt != "None" else None,
        }

    def __str__(self) -> str:
        return str(self.title + self.id)
