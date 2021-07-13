requires 'Encode';
requires 'FFI::C';
requires 'FFI::Platypus';
requires 'Import::Into';
requires 'Ref::Util';
requires 'Role::Tiny';
requires 'Sub::Util', '1.40';

on test => sub {
    requires 'Test2::Suite';
};
