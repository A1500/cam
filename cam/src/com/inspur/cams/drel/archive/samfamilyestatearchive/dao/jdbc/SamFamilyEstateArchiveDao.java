package com.inspur.cams.drel.archive.samfamilyestatearchive.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.samfamilyestatearchive.dao.ISamFamilyEstateArchiveDao;
import com.inspur.cams.drel.archive.samfamilyestatearchive.data.SamFamilyEstateArchive;

/**
 * 家庭财产信息dao
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyEstateArchiveDao extends EntityDao<SamFamilyEstateArchive> implements ISamFamilyEstateArchiveDao {
	
	@Override
	public Class<SamFamilyEstateArchive> getEntityClass() {
		return SamFamilyEstateArchive.class;
	}

}