#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#include <notify.h>
#include <unistd.h>

BOOL isCapable()
{
  return YES;
}

BOOL isEnabled()
{
  notify_post("com.sbsettingstor.checkenabled");
  sleep(1);
  NSFileManager *fileManager = [NSFileManager defaultManager];
  BOOL enabled = [fileManager fileExistsAtPath:@"/tmp/torcheck"];
  [fileManager dealloc];
  return enabled;
}

void setState(BOOL Enable)
{
  if(Enable)
  {
    notify_post("com.sbsettingstor.enable");
  }
  else
  {
    notify_post("com.sbsettingstor.disable");
  }
}

float getDelayTime()
{
  return 1.0f;
}
