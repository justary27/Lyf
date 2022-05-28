from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
import uuid
from User.models import LyfUser

# Create your models here.
class TodoManger(models.Manager):

    def getTodos(self,userId):
        return list(self.filter(_user=LyfUser.objects.get_user_by_id(userId)
        ).all())

    def get_todo_by_id(self, id):
        return self.filter(_id = id).get()

class Todo(models.Model):

    _id = models.UUIDField(
            default=uuid.uuid4,
            auto_created=True,
            primary_key=True, 
            editable=False,
            unique= True,
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
    _is_reminder_set = models.BooleanField(_("isReminderSet"),default=False, editable= False)
    _reminder_at= models.DateTimeField(null=True,blank=True)


    objects = TodoManger()
    @property
    def todoId(self) -> str:
        return str(self._id)

    @property
    def todoTitle(self) -> str:
        return self._title

    @property
    def todoDescription(self) -> str:
        return self._description

    @property
    def CreatedAt(self) -> str:
        return str(self._created_on)

    @property
    def isReminderset(self) -> bool:
        return self._is_reminder_set
    @property
    def ReminderAt(self) -> str:
        return str(self._reminder_at)

    @property
    def asDict(self)->dict:
        return {
            "_id":self.todoId,
            "_title":self.todoTitle,
            "_description": self.todoDescription,
            "_createdAt":self.CreatedAt,
            "_isReminderSet":self.isReminderset,
            "_reminderAt":self.ReminderAt if self.ReminderAt !="None" else None,
        }

    def __str__(self) -> str:
        return str(self.todoTitle+self.todoId)
