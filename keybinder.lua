

--[[

Options['Keybinds'] = {
        ['WaypointVisibility'] = {
            ['Mode'] = 'mode_toggle',
            ['Bind'] = nil,
        }
    },



--]]
require 'lib/lib_UserKeybinds'
require 'lib/lib_InputIcon'

local POPUP = Component.GetFrame('KeybindPopup')
local KEYCATCHER = POPUP:GetChild('KeyCatcher')
local BINDINGS = POPUP:GetChild('Bindings')
local BUTTONS = POPUP:GetChild('Buttons')
local ACCEPT_BUTTON = BUTTONS:GetChild('LeftButton')
local DECLINE_BUTTON = BUTTONS:GetChild('RightButton')

local BOX = {
    [1] = {
        Plate = BINDINGS:GetChild('Box_1'):GetChild('Plate'),
        Icon = BINDINGS:GetChild('Box_1'):GetChild('Icon'),
        InputIcon = nil,
        Text = BINDINGS:GetChild('Box_1'):GetChild('Text'),
    },
    [2] = {
        Plate = BINDINGS:GetChild('Box_2'):GetChild('Plate'),
        Icon = BINDINGS:GetChild('Box_2'):GetChild('Icon'),
        InputIcon = nil,
        Text = BINDINGS:GetChild('Box_2'):GetChild('Text'),
    },
}

local Private = {
    isOpen = false,
    isListening = false,
    activeSlot = nil,
    activeOptionId = nil,
    activeBinds = {},
    KeySet = UserKeybinds.Create(),
}

local c_KeyCode_Escape = 27
local c_KeyCode_LMB = 256
local c_KeyCode_RMB = 257

local c_BannedKeycodes = {
    [c_KeyCode_LMB] = true,
    [c_KeyCode_RMB] = true,
}

local c_LabelDisabledAlpha    = 0.1
local c_LabelNormalAlpha      = 0.6
local c_LabelHighlightAlpha   = 1

local c_NormalTint = "ffffff"
local c_HighlightTint = "ffff00"

local c_BindingDefinitions = {
    ['Keybinds_WaypointVisibilityToggle_Button'] = {
        action = 'waypoint_visibility_toggle',
        func = WaypointManager.ToggleVisibility,
        bindOptionId = 'Keybinds_WaypointVisibilityToggle_Bind',
        bindOptionKey = 'WaypointVisibilityToggle',
    },

    ['Keybinds_HUDTrackerVisibilityToggle_Button'] = {
        action = 'hudtracker_visibility_toggle',
        func = WaypointManager.ToggleVisibility,
        bindOptionId = 'KeybindsHUDTrackerVisibilityToggle_Bind',
        bindOptionKey = 'HUDTrackerVisibilityToggle',
    },

    ['Keybinds_WaypointVisibilityCycle_Button'] = {
        action = 'waypoint_visibility_cycle',
        func = WaypointManager.ToggleVisibility,
        bindOptionId = 'Keybinds_WaypointVisibilityCycle_Bind',
        bindOptionKey = 'WaypointVisibilityCycle',
    },
}


function KeyBinder_Setup()
    -- Title
    POPUP:GetChild('Title'):SetText(Lokii.GetString("KeyBinder_Title"))

    -- Buttons
    ACCEPT_BUTTON:SetText(Lokii.GetString("KeyBinder_AcceptButton"))
    ACCEPT_BUTTON:BindEvent("OnMouseDown", KeyBinder_Save)
    --ACCEPT_BUTTON:SetParam("tint", "00ff00")

    DECLINE_BUTTON:SetText(Lokii.GetString("KeyBinder_DeclineButton"))
    DECLINE_BUTTON:BindEvent("OnMouseDown", KeyBinder_Close)
    DECLINE_BUTTON:SetParam("tint", "ff000a")

    -- InputIcons
    for index, BOX_REF in pairs(BOX) do
        BOX_REF.InputIcon = InputIcon.CreateVisual(BOX_REF.Icon, "Bind")
    end

    -- Keycatcher
    KEYCATCHER:BindEvent('OnKeyCatch', Private.OnKeyCatch)

    -- Load Keybinds
    for buttonOptionId, definition in pairs(c_BindingDefinitions) do
        Private.KeySet:RegisterAction(definition.action, definition.func)

        Options['Keybinds'][definition.bindOptionKey]['Bind'] = Component.GetSetting(definition.bindOptionId) or {}

        Private.Rebind(definition)
    end
end


function KeyBinder_Open(args)
    Debug.Event(args)

    assert(args.id, 'must have option id for keybinder')

    -- Set vars
    Private.isOpen = true
    Private.activeOptionId = args.id
    Private.activeBinds = _table.copy(Options['Keybinds'][c_BindingDefinitions[Private.activeOptionId].bindOptionKey]['Bind']) or {}

    -- Update UI
    Private.UpdatePopupVisuals()

    -- Show
    POPUP:Show(true)
end

function KeyBinder_Close(args)
    Debug.Event(args)

    if Private.isListening then
        Private.CancelKeyCatch()
    end

    -- Reset
    Private.isOpen = false
    Private.isListening = false
    Private.activeSlot = nil
    Private.activeOptionId = nil
    Private.activeBinds = nil

    -- Hide
    POPUP:Show(false)
end

function KeyBinder_MouseDown(args)
    Debug.Event(args)
    PlayClickSound()


    local slot = tonumber(args.widget:GetTag())

    Debug.Log("User clicked slot ", slot)

    -- Enter Binding State
    if Private.activeSlot == nil then
        Private.activeSlot = slot
        Private.StartKeyCatch()

    -- Already in a binding state, do something else ;o
    else
        Private.CancelKeyCatch()
    end

    Private.UpdatePopupVisuals()
end
    
function KeyBinder_MouseEnter(args)
    PlayMouseoverSound()
    --args.widget:ParamTo("alpha", c_LabelHighlightAlpha, 0.1)
end
    
function KeyBinder_MouseLeave(args)
    --args.widget:ParamTo("alpha", c_LabelNormalAlpha, 0.1)
end
    
function KeyBinder_OnEscape(args)
    --Debug.Event(args)
    --KeyBinder_Close(args)
end

function KeyBinder_Save()
    local definition = c_BindingDefinitions[Private.activeOptionId]
    Options['Keybinds'][definition.bindOptionKey]['Bind'] = Private.activeBinds
    Component.SaveSetting(definition.bindOptionId, Private.activeBinds)
    Private.Rebind(definition)
    KeyBinder_Close()
end

function Private.UpdatePopupVisuals()

    -- Binding text
    BINDINGS:GetChild('Label'):SetText(Lokii.GetString(Private.activeOptionId)) 

    -- Icons
    for slot, BOX_REF in pairs(BOX) do

        if Private.activeSlot == slot then
            BOX_REF.Plate:SetParam("tint", c_HighlightTint)
            BOX_REF.Plate:SetParam("alpha", c_LabelNormalAlpha)
        else
            BOX_REF.Plate:SetParam("tint", c_NormalTint)
            BOX_REF.Plate:SetParam("alpha", c_LabelDisabledAlpha)
        end

        local keycode = Private.activeBinds[slot] or "blank"
        BOX_REF.InputIcon:SetBind({keycode=keycode, alt=false}, true)
    end
end


function Private.OnKeyCatch(args)
    Debug.Event(args)

    KEYCATCHER:StopListening()
    Private.isListening = false

    local key = args.widget:GetKeyCode()
    local alt = args.widget:GetAlt()

    if not c_BannedKeycodes[key] then
        Private.ProcessKeyCatch(key, alt)
    else
        Private.CancelKeyCatch(args)
    end

    Private.activeSlot = nil
    
    Private.UpdatePopupVisuals()
end

function Private.StartKeyCatch(args)
    KEYCATCHER:ListenForKey()
    Private.isListening = true
    Private.UpdatePopupVisuals()
end

function Private.ProcessKeyCatch(key, alt)
    Debug.Log("ProcessKeyCatch", Private.activeSlot, key, alt)

    -- Update options value
    if key ~= c_KeyCode_Escape then
        Private.activeBinds[Private.activeSlot] = key
    else
        Private.activeBinds[Private.activeSlot] = nil
    end
end


function Private.CancelKeyCatch(args)
    Debug.Log("CancelKeyCatch")
    KEYCATCHER:StopListening()
    Private.isListening = false
end

function Private.Rebind(definition)
    -- Load keybinds into options, may be duplicate
    Options['Keybinds'][definition.bindOptionKey]['Bind'] = Component.GetSetting(definition.bindOptionId) or {}

    -- Reset keybinds for this action
    Private.KeySet:UnregisterAction(definition.action)
    Private.KeySet:RegisterAction(definition.action, definition.func)

    -- Bind!
    for slot, keycode in pairs(Options['Keybinds'][definition.bindOptionKey]['Bind']) do
        Private.KeySet:BindKey(definition.action, keycode, slot)
    end
end




function PlayMouseoverSound()
    System.PlaySound("rollover")
end

function PlayClickSound()
    System.PlaySound("button_press")
end

