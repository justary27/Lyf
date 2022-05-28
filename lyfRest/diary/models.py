from django.db import models
from django.db import models
from django.utils.translation import gettext_lazy as _
from django.utils import timezone
import uuid
from User.models import LyfUser

# Create your models here.
class DiaryEntryManger(models.Manager):

    def getEntries(self,userId):
        return list(self.filter(_user=LyfUser.objects.get_user_by_id(userId)
        ).all())

    def get_entry_by_id(self, id):
        return self.filter(_id = id).get()

class DiaryEntry(models.Model):

    _id = models.UUIDField(
            default=uuid.uuid4,
            auto_created=True,
            primary_key=True, 
            editable=False,
            unique=True,
        )
    _user = models.ForeignKey(LyfUser, on_delete=models.CASCADE, editable= False)

    _title = models.CharField(
                _("Title"), 
                max_length=120, 
                default="Untitled"
            )
    _description = models.TextField(
                    _("Description"), 
                )

    _created_on = models.DateTimeField(default=timezone.now,)
    
    _audioLink = models.TextField(_("audioFileLink"),blank=True, editable=True, null=True)

    _imageLinks = models.JSONField(_("imageFileLinks"), blank=True, null=True)

    # _audioAttachment = models.FileField(_("Audio Attachment"),upload_to=)

    objects = DiaryEntryManger()
    @property
    def entryId(self) -> str:
        return str(self._id)

    @property
    def entryTitle(self) -> str:
        return self._title

    @property
    def entryDescription(self) -> str:
        return self._description

    @property
    def CreatedAt(self) -> str:
        return str(self._created_on)

    @property
    def audioAttachment(self) -> str:
        return str(self._audioLink)

    @property
    def imageAttachment(self):
        return self._imageLinks

    @property
    def asDict(self)->dict:
        return {
            "_id":self.entryId,
            "_title":self.entryTitle,
            "_description": self.entryDescription,
            "_createdAt":self.CreatedAt,
            "_audioLink":self.audioAttachment if self.audioAttachment!="None" else None,
            "_imageLinks":self.imageAttachment#.replace('\'','').split(',') if self.imageAttachment != "Null" else "Null"
        }

    # def user_directory_path(userInstance,  filename):
    #     return '{0}/pfp/{1}'.format(userInstance._id, filename)

    def __str__(self) -> str:
        return str(self.entryTitle+self.entryId)
