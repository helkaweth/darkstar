---------------------------------------------
--  Heavy Stomp
--
--  Description: Deals heavy damage to targets within an area of effect. Additional effect: Paralysis
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown radial
--  Notes: Paralysis effect has a very long duration.
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local numhits = math.random(2,3);
	local accmod = 1;
	local dmgmod = .7;
	local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_BLUNT,info.hitslanded);

	local typeEffect = EFFECT_PARALYSIS;
	if(target:hasStatusEffect(typeEffect) == false and MobPhysicalHit(skill, dmg, target, info.hitslanded)) then
			local statmod = MOD_INT;
			local resist = applyPlayerResistance(mob,typeEffect,target,mob:getMod(statmod)-target:getMod(statmod),0,ELE_ICE);
			if(resist > 0.2) then
				target:addStatusEffect(typeEffect,10,3,360*resist);--power=8;tic=3;duration=60;
			end
	end

	target:delHP(dmg);
	return dmg;
end;
