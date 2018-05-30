#version 330

in vec3 N; // interpolated normal for the pixel
in vec3 v; // interpolated position for the pixel 
in vec2 textureCoord; // interpolated texture coordinate for the pixel

const int maxNumLights = 50;

uniform vec4 lightSourcePosition[maxNumLights];

// light direction
uniform vec4 lightDirection[maxNumLights];

uniform vec4 diffuseLightIntensity[maxNumLights];
uniform vec4 specularLightIntensity[maxNumLights];
uniform vec4 ambientLightIntensity[maxNumLights];

// for calculating the light attenuation 
uniform float constantAttenuation[maxNumLights];
uniform float linearAttenuation[maxNumLights];
uniform float quadraticAttenuation[maxNumLights];

// Spotlight cutoff angle
uniform float spotlightOuterCone[maxNumLights];
uniform float spotlightInnerCone[maxNumLights];
uniform int lightType[maxNumLights];

uniform int numLights;

uniform vec4 Kambient;
uniform vec4 Kdiffuse;
uniform vec4 Kspecular;
uniform vec4 emission;
uniform float shininess;

uniform vec3 eyePosition;

uniform int hasTexture;
uniform sampler2D texUnit;

out vec4 color;

// This fragment shader is an example of per-pixel lighting.
void main() {

	// Now calculate the parameters for the lighting equation:
	// color = Ka * Lag + (Ka * La) + attenuation * ((Kd * (N dot L) * Ld) + (Ks * ((N dot HV) ^ shininess) * Ls))
	// Ka, Kd, Ks: surface material properties
	// Lag: global ambient light (not used in this example)
	// La, Ld, Ls: ambient, diffuse, and specular components of the light source
	// N: normal
	// L: light vector
	// HV: half vector
	// shininess
	// attenuation: light intensity attenuation over distance and spotlight angle

	//color = vec4(0.0, 0.0, 0.0, 1.0);
	//color = vec4(1.0, 1.0, 0.0, 1.0);
	color = vec4(0.98, 0.68, 0.25, 1.0);
	//rgb(249, 168, 60)
	for (int i = 0; i < numLights; i++) {
		vec3 lightVector;
		float attenuation = 1.0;

		if (lightType[i] == 1) {
			// point light source
			lightVector = normalize(lightSourcePosition[i].xyz - v);

			// calculate light attenuation 
			float distance = distance(lightSourcePosition[i].xyz, v);

			attenuation = 1.0 / (constantAttenuation[i] + (linearAttenuation[i] * distance)
				+ (quadraticAttenuation[i] * distance * distance));

		}
		else if (lightType[i] == 2) {
			// directional light source. The light position is actually the light vector.
			lightVector = lightSourcePosition[i].xyz;

			// For directional lights, there is no light attenuation. 
			attenuation = 1.0;
		}
		else if (lightType[i] == 3) {
			// spotlight source
			lightVector = normalize(lightSourcePosition[i].xyz - v);

			float distance = distance(lightSourcePosition[i].xyz, v);

			float spotEffect = dot(normalize(lightDirection[i].xyz), normalize(lightVector));

			// spotlightInnerCone is in radians, not degrees.
			if (spotEffect > cos(spotlightInnerCone[i])) {
				// If the vertex is in the spotlight cone
				attenuation = spotEffect / (constantAttenuation[i] + linearAttenuation[i] * distance +
					quadraticAttenuation[i] * distance * distance);
			}
			else if (spotEffect > cos(spotlightOuterCone[i])) {
				// Between inner and outer spotlight cone, make the light attenuate sharply. 
				attenuation = (pow(spotEffect, 12)) / (constantAttenuation[i] + linearAttenuation[i] * distance +
					quadraticAttenuation[i] * distance * distance);
			}
			else {
				// If the fragment is outside of the spotlight cone, then there is no light. 
				attenuation = 0.0;
			}
		}
		else {
			attenuation = 0.0;
		}

		//calculate Diffuse Color  
		//float NdotL = max(dot(N, lightVector), 0.0);
		float NdotL = 0.0;

		vec4 diffuseColor = Kdiffuse * diffuseLightIntensity[i] * NdotL;

		// calculate Specular color. Here we use the original Phong illumination model. 
		vec3 E = normalize(eyePosition - v);

		vec3 R = normalize(-reflect(lightVector, N)); // light reflection vector

		//float RdotE = max(dot(R, E), 0.0);
		float RdotE = dot(R, E);

		vec4 specularColor = Kspecular * specularLightIntensity[i] * pow(RdotE, shininess);

		// ambient color
		vec4 ambientColor = Kambient * ambientLightIntensity[i];

		color += ambientColor + emission + attenuation * (diffuseColor + specularColor);
		//color += ambientColor + emission + attenuation * diffuseColor;
		//color += attenuation * (specularColor);
		//color=color;
	}

	if (hasTexture == 1) {
		// Perform the texture mapping. 
		// Retrieve the texture color from the texture image using the texture 
		// coordinates. 
		vec4 textureColor = texture(texUnit, textureCoord);
		// Combine the lighting color with the texture color. 
		// You can use different methods to combine the two colors. 
		//color = mix(color, textureColor, 0.5f);
		color = mix(color, textureColor, 0.5f);
		//color = vec4(1.0, 1.0, 1.0, 0.0);
	}
}

