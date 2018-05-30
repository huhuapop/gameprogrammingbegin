#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 1) uniform sampler2D texSampler;

layout(location = 0) in vec3 fragColor;
layout(location = 1) in vec2 fragTexCoord;

layout(location = 0) out vec4 outColor;

uniform vec4 lightSourcePosition;

// light direction
uniform vec4 lightDirection;

uniform vec4 diffuseLightIntensity;
uniform vec4 specularLightIntensity;
uniform vec4 ambientLightIntensity;

// for calculating the light attenuation 
uniform float constantAttenuation;
uniform float linearAttenuation;
uniform float quadraticAttenuation;

// Spotlight cutoff angle
uniform float spotlightOuterCone;
uniform float spotlightInnerCone;

void main() {
                                        lightVector = normalize(lightSourcePosition[i].xyz - v);

			float distance = distance(lightSourcePosition, v);

			float spotEffect = dot(normalize(lightDirection), normalize(lightVector));

			// spotlightInnerCone is in radians, not degrees.
			if (spotEffect > cos(spotlightInnerCone)) {
				// If the vertex is in the spotlight cone
				attenuation = spotEffect / (constantAttenuation + linearAttenuation * distance +
					quadraticAttenuation * distance * distance);
			}
			else if (spotEffect > cos(spotlightOuterCone)) {
				// Between inner and outer spotlight cone, make the light attenuate sharply. 
				attenuation = (pow(spotEffect, 12)) / (constantAttenuation + linearAttenuation * distance +
					quadraticAttenuation * distance * distance);
			}
			else {
				// If the fragment is outside of the spotlight cone, then there is no light. 
				attenuation = 0.0;
			}
		//calculate Diffuse Color  
		float NdotL = max(dot(N, lightVector), 0.0);

		vec4 diffuseColor = Kdiffuse * diffuseLightIntensity * NdotL;

		// calculate Specular color. Here we use the original Phong illumination model. 
		vec3 E = normalize(eyePosition - v);

		vec3 R = normalize(-reflect(lightVector, N)); // light reflection vector

		float RdotE = max(dot(R, E), 0.0);

		vec4 specularColor = Kspecular * specularLightIntensity * pow(RdotE, shininess);

		// ambient color
		vec4 ambientColor = Kambient * ambientLightIntensity;

		color += ambientColor + emission + attenuation * (diffuseColor + specularColor);
    outColor = texture(texSampler, fragTexCoord);
}