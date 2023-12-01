//
//  File.swift
//  
//
//  Created by Causal Foundry on 30.11.23.
//

/*
import Foundation

final class NudgeUtils {

    /*
    internal func getBodyTextBasedOnTemplate(
        nudgeObjectString: String
    ): String {
        return getBodyTextBasedOnTemplate(
            Gson().fromJson(
                nudgeObjectString,
                BackendNudgeMainObject::class.java
            )
        )
    }
    */

    internal func getBodyTextBasedOnTemplate(
        nudgeObject: BackendNudgeMainObject
    ) -> String {
        if (nudgeObject.nd?.message?.template_config == null) {
            // simple push notification
            return checkBodyForTemplatePlaceholders(nudgeObject)
        } else {
            if (nudgeObject.nd?.message?.template_config?.template_type) {
                "" -> { // simple push notification
                    return checkBodyForTemplatePlaceholders(nudgeObject)
                }

                else {
                    var templateTypes =
                        nudgeObject.definition.message.template_config!!.template_type.split(",")
                            .toTypedArray()
                    var bodyText = nudgeObject.definition.message.body
                    for (tmplType in templateTypes) {
                        if (tmplType.trim() == NudgeTemplateType.item_pair.name) { // item pair notification
                            bodyText = validateAndProvideItemPairString(bodyText, nudgeObject)
                        } else if (tmplType.trim() == NudgeTemplateType.traits.name) { // traits notification
                            bodyText = validateAndProvideTraitsString(bodyText, nudgeObject)
                        } else {
                            ExceptionManager.throwInvalidNudgeException(
                                "Invalid tmpl_cfg.tmpl_type provided",
                                nudgeObject
                            )
                            bodyText = ""
                        }
                    }
                    return bodyText
                }
            }
        }

    }

    private func checkBodyForTemplatePlaceholders(nudgeObject: BackendNudgeMainObject) -> String {
        var regex = "\\{\\{\\s*(.*?)\\s*\\}\\}".toRegex()
        if (regex.find(nudgeObject.nd?.message?.body) != null) {
            ExceptionManager.throwInvalidNudgeException(
                "Empty Template Type but body contains placeholders",
                nudgeObject
            )
            return ""
        }
        return nudgeObject.nd?.message?.body
    }

    private func validateAndProvideTraitsString(
        inputString: String,
        nudgeObject: BackendNudgeMainObject
    ) -> String {

        if (nudgeObject.definition.message.template_config!!.traits_cfg.isNullOrEmpty()) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid tmpl_cfg.traits provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values == null) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid extra provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values!!.traits_extra_object == null) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid extra.traits provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values!!.traits_extra_object.toString().isEmpty()) {
            ExceptionManager.throwInvalidNudgeException(
                "Empty extra.traits provided",
                nudgeObject
            )
            return ""
        } else {
            var traitsMap: Map<String, Any> = HashMap()
            traitsMap = Gson().fromJson(
                nudgeObject.extra_values!!.traits_extra_object.toString(),
                traitsMap.javaClass
            )
            return if (nudgeObject.definition.message.template_config!!.traits_cfg!!.size != traitsMap.size) {
                ExceptionManager.throwInvalidNudgeException(
                    "extra.traits and tmpl_cfg.traits size mismatch",
                    nudgeObject
                )
                ""
            } else if (!nudgeObject.definition.message.template_config!!.traits_cfg!!.all {
                    traitsMap.containsKey(it)
                }) {
                ExceptionManager.throwInvalidNudgeException(
                    "extra.traits and tmpl_cfg.traits values mismatch",
                    nudgeObject
                )
                ""
            } else {
                var nudgeObjectBody = inputString
                for ((key, value) in traitsMap) {
                    nudgeObjectBody = nudgeObjectBody.replace("{{$key}}", value.toString())
                    nudgeObjectBody = nudgeObjectBody.replace("{{ $key }}", value.toString())
                }
                nudgeObjectBody
            }
        }

    }

    private func validateAndProvideItemPairString(
        inputString: String,
        nudgeObject: BackendNudgeMainObject
    ) -> String {

        if (nudgeObject.definition.message.template_config!!.item_pair_cfg == null) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid tmpl_cfg.item_pair_cfg provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.definition.message.template_config!!.item_pair_cfg!!.item_type.isNullOrEmpty()) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid tmpl_cfg.item_pair_cfg.item_type provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values == null) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid extra provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values!!.item_pair_extra_object == null) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid extra.item_pair provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values!!.item_pair_extra_object!!.names.size != 2) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid extra.item_pair.names values provided",
                nudgeObject
            )
            return ""
        } else if (nudgeObject.extra_values!!.item_pair_extra_object!!.ids.size != 2) {
            ExceptionManager.throwInvalidNudgeException(
                "Invalid extra.item_pair.ids values provided",
                nudgeObject
            )
            return ""
        } else {
            return inputString
                .replace(
                    "{{ primary }}",
                    nudgeObject.extra_values!!.item_pair_extra_object!!.names[0]
                )
                .replace(
                    "{{primary}}",
                    nudgeObject.extra_values!!.item_pair_extra_object!!.names[0]
                )
                .replace(
                    "{{ secondary }}",
                    nudgeObject.extra_values!!.item_pair_extra_object!!.names[1]
                )
                .replace(
                    "{{secondary}}",
                    nudgeObject.extra_values!!.item_pair_extra_object!!.names[1]
                )
        }
    }

    /*
    internal func getBitmapFromURL(strURL: String?): Bitmap? {
        return try {
            var url = URL(string: strURL)
            var connection: HttpURLConnection = url.openConnection() as HttpURLConnection
            connection.doInput = true
            connection.connect()
            var input: InputStream = connection.inputStream
            BitmapFactory.decodeStream(input)
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }
    }

    
    internal func vectorToBitmap(context: Context, drawableId: Int): Bitmap? {
        var drawable = context.getDrawable(drawableId) ?: return null
        var bitmap = Bitmap.createBitmap(
            drawable.intrinsicWidth, drawable.intrinsicHeight, Bitmap.Config.ARGB_8888
        ) ?: return null
        var canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }
*/
}
*/
