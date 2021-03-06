%fragment("v8_initializer", "templates") %{
void ${MODULE}_Initialize(v8::Handle<v8::Context> context)
{
    v8::HandleScope scope;
    v8::Local<v8::Object> global = context->Global();

    /* create object templates for namespaces */
    ${PART_NAMESPACES}
    
    /* create class templates */
    ${PART_CLASS_TEMPLATES}
    
    /* register wrapper functions */
    ${PART_WRAPPERS}
    
    /* setup inheritances */
    ${PART_INHERITANCE}
    
    /* class instances */
    ${PART_CLASS_INSTANCES}

    /* add static class functions and variables */
    ${PART_STATIC_WRAPPERS}
    
    /* register classes */
    ${PART_REGISTER_CLASSES}
    
    /* create and register namespace objects */
    ${PART_REGISTER_NS}
}%}

%fragment("v8_declare_class_template", "templates") %{
v8::Persistent<v8::FunctionTemplate> SWIGV8_${NAME_MANGLED};%}

%fragment("v8_define_class_template", "templates") %{
SWIGV8_${NAME_MANGLED} = SWIGV8_CreateClassTemplate("${NAME_UNQUALIFIED}" , ${NAME_MANGLED}_new);%}

%fragment("v8_create_class_instance", "templates") %{
v8::Handle<v8::Object> class_${NAME_MANGLED} = SWIGV8_${NAME_MANGLED}->GetFunction();%}

%fragment("v8_inherit", "templates") %{
SWIGV8_${NAME_MANGLED}->Inherit(SWIGV8_${BASE_CLASS});%}

%fragment("v8_register_class", "templates") %{
${CONTEXT}->Set(v8::String::NewSymbol("${NAME_UNQUALIFIED}"), class_${NAME_MANGLED});%}

%fragment("v8_ctor_wrapper", "templates") %{
v8::Handle<v8::Value> ${NAME_MANGLED}_new(const v8::Arguments& args) {
    v8::HandleScope scope;
    v8::Handle<v8::Object> self = args.Holder();
    ${LOCALS}
    ${CODE}
    self->SetInternalField(0, v8::External::New(result));
    return self;        
}%}

%fragment("v8_getter", "templates") %{
v8::Handle<v8::Value> ${NAME_MANGLED}_get(v8::Local<v8::String> property, const v8::AccessorInfo& info) {
    v8::HandleScope scope;
    v8::Handle<v8::Object> jsresult;
    ${LOCALS}
    ${CODE}
    return scope.Close(jsresult);
}%}

%fragment("v8_setter", "templates") %{
void ${NAME_MANGLED}_set(v8::Local<v8::String> property, v8::Local<v8::Value> value, const v8::AccessorInfo& info) {
    ${LOCALS}
    ${CODE}
}%}

%fragment("v8_function", "templates") %{
v8::Handle<v8::Value> wrap_${NAME_MANGLED}(const Arguments &args) {
    v8::HandleScope scope;
    v8::Handle<v8::Object> jsresult;
    ${LOCALS}
    ${CODE}
    return scope.Close(jsresult);
}%}

%fragment("v8_create_namespace", "templates") %{
v8::Handle<v8::ObjectTemplate> ${NAME_MANGLED} = v8::ObjectTemplate::New();%}

%fragment("v8_register_member_function", "templates") %{
SWIGV8_AddMemberFunction(SWIGV8_${CLASSNAME_MANGLED}, "${NAME_UNQUALIFIED}", wrap_${NAME_MANGLED});%}

%fragment("v8_register_global_function", "templates") %{
SWIGV8_AddGlobalFunction(${CONTEXT}, "${NAME_UNQUALIFIED}", wrap_${NAME_MANGLED});%}

%fragment("v8_register_member_variable", "templates") %{
SWIGV8_AddMemberVariable(SWIGV8_${CLASSNAME_MANGLED}, "${NAME_UNQUALIFIED}", ${GETTER}, ${SETTER});%}

%fragment("v8_register_global_variable", "templates") %{
SWIGV8_AddGlobalVariable(${CONTEXT}, "${NAME_UNQUALIFIED}", ${GETTER}, ${SETTER});%}

%fragment("v8_register_namespace", "templates") %{
${CONTEXT}->Set(v8::String::NewSymbol("${NAME_UNQUALIFIED}", ${NAME_MANGLED}->NewInstance()));%}

%fragment("v8_this_ptr", "templates") %{
arg1 = SWIGV8_UnwrapThisPointer<${TYPE}>(${ARG}.Holder());
%}
