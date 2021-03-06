%insert(runtime) %{

/**
 * Creates a class template for a class with specified initialization function. 
 */
v8::Persistent<v8::FunctionTemplate> SWIGV8_CreateClassTemplate(const char* symbol, v8::InvocationCallback _func) {
    v8::Local<v8::FunctionTemplate> class_templ = v8::FunctionTemplate::New(_func);
    class_templ->SetClassName(v8::String::NewSymbol(symbol));

    v8::Handle<v8::ObjectTemplate> inst_templ = class_templ->InstanceTemplate();
    inst_templ->SetInternalFieldCount(1);

    return v8::Persistent<v8::FunctionTemplate>::New(class_templ);
}

v8::Handle<v8::ObjectTemplate> SWIGV8_CreateNamespace(const char* name, v8::Handle<v8::Context> parentContext) {
    Handle<ObjectTemplate> namespace = ObjectTemplate::New();
}

/**
 * Registers a class method with given name for a given class template. 
 */
void SWIGV8_AddMemberFunction(v8::Handle<v8::FunctionTemplate> class_templ, const char* symbol, v8::InvocationCallback _func) {
    v8::Handle<v8::ObjectTemplate> proto_templ = class_templ->PrototypeTemplate();
    proto_templ->Set(v8::String::NewSymbol(symbol), v8::FunctionTemplate::New(_func));    
}

/**
 * Registers a class method with given name for a given class template. 
 */
void SWIGV8_AddGlobalFunction(v8::Handle<v8::ObjectTemplate> obj_templ, const char* symbol, v8::InvocationCallback _func) {
    obj_templ->Set(String::NewSymbol(symbol), v8::FunctionTemplate::New(_func)->GetFunction());
}

/**
 * Registers a class property with given name for a given class template. 
 */
void SWIGV8_AddMemberVariable(v8::Handle<v8::FunctionTemplate> class_templ, const char* symbol, v8::AccessorGetter getter, v8::AccessorSetter setter) {
    v8::Handle<v8::ObjectTemplate> proto_templ = class_templ->InstanceTemplate();
    proto_templ->SetAccessor(v8::String::NewSymbol(symbol), getter, setter);
}

/**
 * Registers a class method with given name for a given class template. 
 */
void SWIGV8_AddGlobalVariable(v8::Handle<v8::ObjectTemplate> obj_templ, const char* symbol, v8::AccessorGetter getter, v8::AccessorSetter setter) {
    obj_templ->SetAccessor(String::NewSymbol(symbol), getter, setter);
}
%} // v8_helper_functions
