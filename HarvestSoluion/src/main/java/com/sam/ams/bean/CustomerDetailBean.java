package com.sam.ams.bean;

import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
"value",
"text"
})
public class CustomerDetailBean {

@JsonProperty("value")
private Integer id;
@JsonProperty("text")
private String firstName;
@JsonIgnore
private Map<String, Object> additionalProperties = new HashMap<String, Object>();

@JsonProperty("value")
public Integer getId() {
return id;
}

@JsonProperty("value")
public void setId(Integer id) {
this.id = id;
}

@JsonProperty("text")
public String getFirstName() {
return firstName;
}

@JsonProperty("text")
public void setFirstName(String firstName) {
this.firstName = firstName;
}

@JsonAnyGetter
public Map<String, Object> getAdditionalProperties() {
return this.additionalProperties;
}

@JsonAnySetter
public void setAdditionalProperty(String name, Object value) {
this.additionalProperties.put(name, value);
}

}