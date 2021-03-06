-----------------------------------------
-- Spell: Occultation
-- Creates shadow images that each absorb a single attack directed at you
-- Spell cost: 138 MP
-- Monster Type: Seethers
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+3 CHR-2 
-- Level: 88
-- Casting Time: 2 seconds
-- Recast Time: 1 minute, 30 seconds
-- 
-- Combos: Evasion Bonus
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnMagicCastingCheck
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0;
end;-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)

    local skill = caster:getSkillLevel(BLUE_SKILL);
    local shadows = 2;
    local duration = 300;

    -- 400 skill = 8 shadows, 450 = 9 shadows, so I am assuming every 50 skill is a shadow.
    -- Also assuming minimum of 2 shadows.
    -- I've never seen the spell cast with under 100 skill, so I could be wrong.
    if (skill > 100) then
        shadows = (skill / 50);
    end

    if(caster:hasStatusEffect(EFFECT_DIFFUSION)) then
        local diffMerit = caster:getMerit(MERIT_DIFFUSION);

        if(diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit;
        end

        caster:delStatusEffect(EFFECT_DIFFUSION);
    end

    if(target:addStatusEffect(EFFECT_BLINK, shadows, 0, duration)) then
        spell:setMsg(230);
    else
        spell:setMsg(75);
    end

    return EFFECT_BLINK;
end;