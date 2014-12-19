package com.inspur.cams.drel.archive.samfamilyhousearchive.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.samfamilyhousearchive.dao.ISamFamilyHouseArchiveDao;
import com.inspur.cams.drel.archive.samfamilyhousearchive.data.SamFamilyHouseArchive;

/**
 * 基础信息_房屋信息dao
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyHouseArchiveDao extends EntityDao<SamFamilyHouseArchive> implements ISamFamilyHouseArchiveDao {
	
	@Override
	public Class<SamFamilyHouseArchive> getEntityClass() {
		return SamFamilyHouseArchive.class;
	}

}