package com.inspur.cams.drel.archive.samfamilysupportarchive.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.archive.samfamilysupportarchive.dao.ISamFamilySupportArchiveDao;
import com.inspur.cams.drel.archive.samfamilysupportarchive.data.SamFamilySupportArchive;

/**
 * 赡扶抚养人dao
 * @author 
 * @date 2012-06-28
 */
public class SamFamilySupportArchiveDao extends EntityDao<SamFamilySupportArchive> implements ISamFamilySupportArchiveDao {
	
	@Override
	public Class<SamFamilySupportArchive> getEntityClass() {
		return SamFamilySupportArchive.class;
	}

}