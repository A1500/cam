package com.inspur.cams.drel.archive.samfamilyassistancearchive.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.samfamilyassistancearchive.dao.ISamFamilyAssistanceArchiveDao;
import com.inspur.cams.drel.archive.samfamilyassistancearchive.data.SamFamilyAssistanceArchive;

/**
 * 社会救助_救助基本信息dao
 * @author 
 * @date 2012-06-28
 */
public class SamFamilyAssistanceArchiveDao extends EntityDao<SamFamilyAssistanceArchive> implements ISamFamilyAssistanceArchiveDao {
	
	@Override
	public Class<SamFamilyAssistanceArchive> getEntityClass() {
		return SamFamilyAssistanceArchive.class;
	}

}