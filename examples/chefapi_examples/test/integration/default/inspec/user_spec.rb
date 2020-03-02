# Inspec tests for the user chef api go module
#

describe command('/go/src/chefapi_test/bin/user') do
  its('stderr') { should match(%r{^Issue creating user: POST https://localhost/users: 409}) }
  its('stderr') { should_not match(/error|no such file|cannot find|not used|undefined/) }
  its('stdout') { should match(%r{^List initial users map\[(?=.*pivotal:https://localhost/users/pivotal).*\] EndInitialList}) }
  its('stdout') { should match(%r{^Add usr1 \{https://localhost/users/usr1 \}) }
  its('stdout') { should match(%r{^Filter users map\[usr1:https://localhost/users/usr1\]}) }
  its('stdout') { should match(%r{^Get usr1 \{UserName:usr1 DisplayName:User1 Email:user1@domain.io ExternalAuthenticationUid: FirstName:user1  LastName:fullname MiddleName: Password: PublicKey: RecoveryAuthenticationEnabled:false Admin:false}) }
  its('stdout') { should match(/^Pivotal user \{UserName:pivotal DisplayName:Chef Server Superuser Email:root@localhost.localdomain ExternalAuthenticationUid: FirstName:Chef  LastName:Server MiddleName: Password: PublicKey:-----BEGIN/) }
  its('stdout') { should match(%r{^List after adding map\[(?=.*pivotal:https://localhost/users/pivotal)(?=.*usr1:https://localhost/user/usr1).*\] EndAddList}) }
  its('stdout') { should match(%r{^Verbose out    }) }
  its('stdout') { should match(/^Get usr1 \{UserName:usr1 DisplayName:User1 Email:user1@domain.io ExternalAuthenticationUid: FirstName:user1 LastName:fullname MiddleName: Password: PublicKey:-----BEGIN/) }
  its('stdout') { should match(%r{^List after adding map\[(?=.*pivotal:https://localhost/users/pivotal)(?=.*usr1:https://localhost/users/usr1).*\] EndAddList}) }
  its('stdout') { should match(/^Update usr1 partial update \{Uri:https:\/\/localhost\/users\/usr1 PrivateKey: Admin:\}/) }
  its('stdout') { should match(/^Get usr1 after partial update \{UserName:usr1 DisplayName:user1 Email:myuser@samp.com ExternalAuthenticationUid: FirstName:user1 LastName:fullname MiddleName: Password: PublicKey: RecoveryAuthenticationEnabled:false Admin:false\}/) }
  its('stdout') { should match(/^Update usr1 full update \{Uri:https:\/\/localhost\/users\/usr1 PrivateKey: Admin:\}/) }
  its('stdout') { should match(/^Get usr1 after full update \{UserName:usr1 DisplayName:user1 Email:myuser@samp.com ExternalAuthenticationUid: FirstName:user LastName:name MiddleName:mid Password: PublicKey: RecoveryAuthenticationEnabled:false Admin:false\}/) }
  its('stdout') { should match(/^Update usr1 rename \{Uri:https:\/\/localhost\/users\/usr1new PrivateKey: Admin:\}/) }
  its('stdout') { should match(/^Get usr1 after rename \{UserName:usr1new DisplayName:user1 Email:myuser@samp.com ExternalAuthenticationUid: FirstName:user LastName:name MiddleName:mid Password: PublicKey: RecoveryAuthenticationEnabled:false Admin:false\}/) }
  its('stdout') { should match(/^Delete usr1 DELETE https:\/\/localhost\/users\/usr1: 404/) }
  its('stdout') { should match(/^Delete usr1new <nil>/) }
  its('stdout') { should match(%r{^List after cleanup map\[(?=.*pivotal:https://localhost/users/pivotal).*\] EndCleanupList}) }
end
