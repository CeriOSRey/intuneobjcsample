//
//  AuthenticationManager.h
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import <Foundation/Foundation.h>
#import <MSAL/MSAL.h>
#import <MSGraphClientSDK/MSGraphClientSDK.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GetTokenCompletionBlock)(NSString* _Nullable accessToken, NSError* _Nullable error);

@interface AuthenticationManager : NSObject<MSAuthenticationProvider>

+ (id) instance;
- (void) getTokenInteractivelyWithParentView: (UIViewController*) parentView
                          andCompletionBlock: (GetTokenCompletionBlock)completionBlock;
- (void) getTokenSilentlyWithCompletionBlock: (GetTokenCompletionBlock)completionBlock;
- (void) signOut;
- (void) getAccessTokenForProviderOptions:(id<MSAuthenticationProviderOptions>)authProviderOptions
                            andCompletion:(void (^)(NSString *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
