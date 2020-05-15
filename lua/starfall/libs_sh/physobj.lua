-- Global to all starfalls
local checkluatype = SF.CheckLuaType

local function checkvector(v)
	if v[1]<-1e12 or v[1]>1e12 or v[1]~=v[1] or
	   v[2]<-1e12 or v[2]>1e12 or v[2]~=v[2] or
	   v[3]<-1e12 or v[3]>1e12 or v[3]~=v[3] then

		SF.Throw("Input vector too large or NAN", 3)

	end
end


--- PhysObj Type
-- @name PhysObj
-- @class type
-- @libtbl physobj_methods
SF.RegisterType("PhysObj", true, false)


return function(instance)
local checkpermission = instance.player ~= NULL and SF.Permissions.check or function() end


local physobj_methods, physobj_meta, wrap, unwrap = instance.Types.PhysObj.Methods, instance.Types.PhysObj, instance.Types.PhysObj.Wrap, instance.Types.PhysObj.Unwrap
local ent_meta, ewrap, eunwrap = instance.Types.Entity, instance.Types.Entity.Wrap, instance.Types.Entity.Unwrap
local ang_meta, awrap, aunwrap = instance.Types.Angle, instance.Types.Angle.Wrap, instance.Types.Angle.Unwrap
local vec_meta, vwrap, vunwrap = instance.Types.Vector, instance.Types.Vector.Wrap, instance.Types.Vector.Unwrap
local mtx_meta, mwrap, munwrap = instance.Types.VMatrix, instance.Types.VMatrix.Wrap, instance.Types.VMatrix.Unwrap

-- @name builtins_library.FVPHYSICS
-- @class table
-- @field CONSTRAINT_STATIC
-- @field DMG_DISSOLVE
-- @field DMG_SLICE
-- @field HEAVY_OBJECT
-- @field MULTIOBJECT_ENTITY
-- @field NO_IMPACT_DMG
-- @field NO_NPC_IMPACT_DMG
-- @field NO_PLAYER_PICKUP
-- @field NO_SELF_COLLISIONS
-- @field PART_OF_RAGDOLL
-- @field PENETRATING
-- @field PLAYER_HELD
-- @field WAS_THROWN
instance.env.FVPHYSICS = {
	["CONSTRAINT_STATIC"] = FVPHYSICS_CONSTRAINT_STATIC,
	["DMG_DISSOLVE"] = FVPHYSICS_DMG_DISSOLVE,
	["DMG_SLICE"] = FVPHYSICS_DMG_SLICE,
	["HEAVY_OBJECT"] = FVPHYSICS_HEAVY_OBJECT,
	["MULTIOBJECT_ENTITY"] = FVPHYSICS_MULTIOBJECT_ENTITY,
	["NO_IMPACT_DMG"] = FVPHYSICS_NO_IMPACT_DMG,
	["NO_NPC_IMPACT_DMG"] = FVPHYSICS_NO_NPC_IMPACT_DMG,
	["NO_PLAYER_PICKUP"] = FVPHYSICS_NO_PLAYER_PICKUP,
	["NO_SELF_COLLISIONS"] = FVPHYSICS_NO_SELF_COLLISIONS,
	["PART_OF_RAGDOLL"] = FVPHYSICS_PART_OF_RAGDOLL,
	["PENETRATING"] = FVPHYSICS_PENETRATING,
	["PLAYER_HELD"] = FVPHYSICS_PLAYER_HELD,
	["WAS_THROWN"] = FVPHYSICS_WAS_THROWN,
}

--- Checks if the physics object is valid
-- @shared
-- @return boolean if the physics object is valid
function physobj_methods:isValid()
	return unwrap(self):IsValid()
end

--- Gets the entity attached to the physics object
-- @shared
-- @return The entity attached to the physics object
function physobj_methods:getEntity()
	return ewrap(unwrap(self):GetEntity())
end

--- Gets the position of the physics object
-- @shared
-- @return Vector position of the physics object
function physobj_methods:getPos()
	return vwrap(unwrap(self):GetPos())
end

--- Returns the world transform matrix of the physobj
-- @shared
-- @return The matrix
function physobj_methods:getMatrix()
	return mwrap(unwrap(self):GetPositionMatrix())
end

--- Gets the angles of the physics object
-- @shared
-- @return Angle angles of the physics object
function physobj_methods:getAngles()
	return awrap(unwrap(self):GetAngles())
end

--- Gets the velocity of the physics object
-- @shared
-- @return Vector velocity of the physics object
function physobj_methods:getVelocity()
	return vwrap(unwrap(self):GetVelocity())
end

--- Gets the axis aligned bounding box of the physics object
-- @shared
-- @return The mins of the AABB
-- @return The maxs of the AABB
function physobj_methods:getAABB()
	local a, b = unwrap(self):GetAABB()
	return vwrap(a), vwrap(b)
end

--- Gets the velocity of the physics object at an arbitrary point in its local reference frame
--- This includes velocity at the point induced by rotational velocity
-- @shared
-- @param vec The point to get velocity of in local reference frame
-- @return Vector Local velocity of the physics object at the point
function physobj_methods:getVelocityAtPoint(vec)
	return vwrap(unwrap(self):GetVelocityAtPoint(vunwrap(vec)))
end

--- Gets the angular velocity of the physics object
-- @shared
-- @return Vector angular velocity of the physics object
function physobj_methods:getAngleVelocity()
	return vwrap(unwrap(self):GetAngleVelocity())
end

--- Gets the mass of the physics object
-- @shared
-- @return mass of the physics object
function physobj_methods:getMass()
	return unwrap(self):GetMass()
end

--- Gets the center of mass of the physics object in the local reference frame.
-- @shared
-- @return Center of mass vector in the physobject's local reference frame.
function physobj_methods:getMassCenter()
	return vwrap(unwrap(self):GetMassCenter())
end

--- Gets the inertia of the physics object
-- @shared
-- @return Vector Inertia of the physics object
function physobj_methods:getInertia()
	return vwrap(unwrap(self):GetInertia())
end

--- Gets the material of the physics object
-- @shared
-- @return The physics material of the physics object
function physobj_methods:getMaterial()
	return unwrap(self):GetMaterial()
end

--- Returns a vector in the local reference frame of the physicsobject from the world frame
-- @param vec The vector to transform
-- @return The transformed vector
function physobj_methods:worldToLocal(vec)
	return vwrap(unwrap(self):WorldToLocal(vunwrap(vec)))
end

--- Returns a vector in the reference frame of the world from the local frame of the physicsobject
-- @param vec The vector to transform
-- @return The transformed vector
function physobj_methods:localToWorld(vec)
	return vwrap(unwrap(self):LocalToWorld(vunwrap(vec)))
end

--- Returns a normal vector in the local reference frame of the physicsobject from the world frame
-- @param vec The normal vector to transform
-- @return The transformed vector
function physobj_methods:worldToLocalVector(vec)
	return vwrap(unwrap(self):WorldToLocalVector(vunwrap(vec)))
end

--- Returns a normal vector in the reference frame of the world from the local frame of the physicsobject
-- @param vec The normal vector to transform
-- @return The transformed vector
function physobj_methods:localToWorldVector(vec)
	return vwrap(unwrap(self):LocalToWorldVector(vunwrap(vec)))
end

--- Returns a table of MeshVertex structures where each 3 vertices represent a triangle. See: http://wiki.facepunch.com/gmod/Structures/MeshVertex
-- @return table of MeshVertex structures
function physobj_methods:getMesh()
	local mesh = unwrap(self):GetMesh()
	return instance.Sanitize(mesh)
end

--- Returns a structured table, the physics mesh of the physics object. See: http://wiki.facepunch.com/gmod/Structures/MeshVertex
-- @return table of MeshVertex structures
function physobj_methods:getMeshConvexes()
	local mesh = unwrap(self):GetMeshConvexes()
	return instance.Sanitize(mesh)
end

--- Sets the physical material of a physics object
-- @param material The physical material to set it to
function physobj_methods:setMaterial(material)
	checkluatype (material, TYPE_STRING)
	local phys = unwrap(self)
	checkpermission(instance, phys:GetEntity(), "entities.setRenderProperty")
	phys:SetMaterial(material)
	if not phys:IsMoveable() then
		phys:EnableMotion(true)
		phys:EnableMotion(false)
	end
end

if SERVER then
	--- Sets the position of the physics object. Will cause interpolation of the entity in clientside, use entity.setPos to avoid this.
	-- @server
	-- @param pos The position vector to set it to
	function physobj_methods:setPos(pos)

		pos = vunwrap(pos)
		checkvector(pos)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.setPos")
		phys:SetPos(pos)
	end

	--- Sets the angles of the physics object. Will cause interpolation of the entity in clientside, use entity.setAngles to avoid this.
	-- @server
	-- @param ang The angle to set it to
	function physobj_methods:setAngles(ang)

		ang = aunwrap(ang)
		checkvector(ang)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.setAngles")
		phys:SetAngles(ang)
	end

	--- Sets the velocity of the physics object
	-- @server
	-- @param vel The velocity vector to set it to
	function physobj_methods:setVelocity(vel)

		vel = vunwrap(vel)
		checkvector(vel)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.setVelocity")
		phys:SetVelocity(vel)
	end

	--- Sets the buoyancy ratio of a physobject
	-- @server
	-- @param ratio The buoyancy ratio to use
	function physobj_methods:setBuoyancyRatio(ratio)
		checkluatype(ratio, TYPE_NUMBER)

		if ratio<-1e12 or ratio>1e12 or ratio~=ratio then
			SF.Throw("Input number too large or NAN", 2)
		end

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.setMass")
		phys:SetBuoyancyRatio(ratio)
	end

	--- Applys a force to the center of the physics object
	-- @server
	-- @param force The force vector to apply
	function physobj_methods:applyForceCenter(force)

		force = vunwrap(force)
		checkvector(force)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")
		phys:ApplyForceCenter(force)
	end

	--- Applys an offset force to a physics object
	-- @server
	-- @param force The force vector to apply
	-- @param position The position in world coordinates
	function physobj_methods:applyForceOffset(force, position)

		force = vunwrap(force)
		checkvector(force)
		position = vunwrap(position)
		checkvector(position)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")
		phys:ApplyForceOffset(force, position)
	end

	--- Sets the angular velocity of an object
	-- @server
	-- @param angvel The local angvel vector to set
	function physobj_methods:setAngleVelocity(angvel)
		angvel = vunwrap(angvel)
		checkvector(angvel)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")

		phys:AddAngleVelocity(angvel - phys:GetAngleVelocity())
	end

	--- Applys a angular velocity to an object
	-- @server
	-- @param angvel The local angvel vector to apply
	function physobj_methods:addAngleVelocity(angvel)
		angvel = vunwrap(angvel)
		checkvector(angvel)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")

		phys:AddAngleVelocity(angvel)
	end

	--- Applys a torque to a physics object
	-- @server
	-- @param torque The world torque vector to apply
	function physobj_methods:applyTorque(torque)
		torque = vunwrap(torque)
		checkvector(torque)

		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")

		phys:ApplyTorqueCenter(torque)
	end

	--- Sets the mass of a physics object
	-- @server
	-- @param mass The mass to set it to
	function physobj_methods:setMass(mass)
		checkluatype(mass, TYPE_NUMBER)
		local phys = unwrap(self)
		local ent = phys:GetEntity()
		checkpermission(instance, ent, "entities.setMass")
		local m = math.Clamp(mass, 1, 50000)
		phys:SetMass(m)
		duplicator.StoreEntityModifier(ent, "mass", { Mass = m })
	end

	--- Sets the inertia of a physics object
	-- @server
	-- @param inertia The inertia vector to set it to
	function physobj_methods:setInertia(inertia)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.setInertia")

		local vec = vunwrap(inertia)
		checkvector(vec)
		vec[1] = math.Clamp(vec[1], 1, 100000)
		vec[2] = math.Clamp(vec[2], 1, 100000)
		vec[3] = math.Clamp(vec[3], 1, 100000)

		phys:SetInertia(vec)
	end
	
	
	local validGameFlags = FVPHYSICS_DMG_DISSOLVE + FVPHYSICS_DMG_SLICE + FVPHYSICS_HEAVY_OBJECT + FVPHYSICS_NO_IMPACT_DMG +
		FVPHYSICS_NO_NPC_IMPACT_DMG + FVPHYSICS_NO_PLAYER_PICKUP
	--- Adds game flags to the physics object. Some flags cannot be modified. Can be:
	-- FVPHYSICS.DMG_DISSOLVE
	-- FVPHYSICS.DMG_SLICE
	-- FVPHYSICS.HEAVY_OBJECT
	-- FVPHYSICS.NO_IMPACT_DMG
	-- FVPHYSICS.NO_NPC_IMPACT_DMG
	-- FVPHYSICS.NO_PLAYER_PICKUP
	-- @param flags The flags to add. FVPHYSICS enum.
	function physobj_methods:addGameFlags(flags)
		checkluatype(flags, TYPE_NUMBER)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.canTool")
		local invalidFlags = bit.band(bit.bnot(validGameFlags), flags)
		if invalidFlags == 0 then
			phys:AddGameFlag(flags)
		else
			SF.Throw("Invalid flags " .. invalidFlags, 2)
		end
	end
	
	--- Clears game flags from the physics object. Some flags cannot be modified. Can be:
	-- FVPHYSICS.DMG_DISSOLVE
	-- FVPHYSICS.DMG_SLICE
	-- FVPHYSICS.HEAVY_OBJECT
	-- FVPHYSICS.NO_IMPACT_DMG
	-- FVPHYSICS.NO_NPC_IMPACT_DMG
	-- FVPHYSICS.NO_PLAYER_PICKUP
	-- @param flags The flags to add. FVPHYSICS enum.
	function physobj_methods:clearGameFlags(flags)
		checkluatype(flags, TYPE_NUMBER)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.canTool")
		local invalidFlags = bit.band(bit.bnot(validGameFlags), flags)
		if invalidFlags == 0 then
			phys:ClearGameFlag(flags)
		else
			SF.Throw("Invalid flags " .. invalidFlags, 2)
		end
	end
	
	--- Returns whether the game flags of the physics object are set.
	-- @param flags The flags to test. FVPHYSICS enum.
	-- @return boolean If the flags are set
	function physobj_methods:hasGameFlags(flags)
		checkluatype(flags, TYPE_NUMBER)
		local phys = unwrap(self)
		return phys:HasGameFlag(flags)
	end
	
	--- Sets bone gravity
	-- @param grav Bool should the bone respect gravity?
	function physobj_methods:enableGravity(grav)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.enableGravity")
		phys:EnableGravity(grav and true or false)
		phys:Wake()
	end

	--- Sets the bone drag state
	-- @param drag Bool should the bone have air resistence?
	function physobj_methods:enableDrag(drag)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.enableDrag")
		phys:EnableDrag(drag and true or false)
	end

	--- Check if bone is affected by air resistance
	-- @return boolean If bone is affected by drag
	function physobj_methods:isDragEnabled()
		local phys = unwrap(self)
		return phys:IsDragEnabled()
	end

	--- Sets coefficient of air resistance affecting the bone. Air resistance depends on the cross-section of the object.
	-- @param coeff Number how much drag affects the bone
	function physobj_methods:setDragCoefficient(coeff)
		checkluatype(coeff, TYPE_NUMBER)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.enableDrag")
		phys:SetDragCoefficient(coeff)
	end

	--- Sets coefficient of air resistance affecting the bone when rotating. Air resistance depends on the cross-section of the object.
	-- @param coeff Number how much drag affects the bone when rotating
	function physobj_methods:setAngleDragCoefficient(coeff)
		checkluatype(coeff, TYPE_NUMBER)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.enableDrag")
		phys:SetAngleDragCoefficient(coeff)
	end

	--- Returns Movement damping of the bone.
	-- @return Linear damping
	-- @return Angular damping
	function physobj_methods:getDamping()
		local phys = unwrap(self)
		return phys:GetDamping()
	end
	
	--- Sets the movement damping of the bone. Unlike air drag, it doesn't take into account the cross-section of the object.
	-- @param linear Number of the linear damping
	-- @param angular Number of the angular damping
	function physobj_methods:setDamping(linear, angular)
		checkluatype(linear, TYPE_NUMBER)
		checkluatype(angular, TYPE_NUMBER)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.setDamping")
		return phys:SetDamping(linear, angular)
	end
	
	--- Sets the bone movement state
	-- @param move Bool should the bone move?
	function physobj_methods:enableMotion(move)
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.enableMotion")
		phys:EnableMotion(move and true or false)
		phys:Wake()
	end

	--- Returns whether the physobj is asleep
	-- @server
	-- @return boolean if the physobj is asleep
	function physobj_methods:isAsleep()
		local phys = unwrap(self)
		return phys:IsAsleep()
	end

	--- Makes a physobj go to sleep. (like it's frozen but interacting wakes it back up)
	-- @server
	function physobj_methods:sleep()
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")
		phys:Sleep()
	end

	--- Makes a sleeping physobj wakeup
	-- @server
	function physobj_methods:wake()
		local phys = unwrap(self)
		checkpermission(instance, phys:GetEntity(), "entities.applyForce")
		phys:Wake()
	end
end

end
