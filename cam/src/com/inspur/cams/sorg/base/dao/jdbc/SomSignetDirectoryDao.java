package com.inspur.cams.sorg.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.sorg.base.dao.ISomSignetDirectoryDao;
import com.inspur.cams.sorg.base.data.SomSignetDirectory;

/**
 * 印章名录dao实现类
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomSignetDirectoryDao extends EntityDao<SomSignetDirectory>
		implements ISomSignetDirectoryDao {

	@Override
	public Class<SomSignetDirectory> getEntityClass() {
		return SomSignetDirectory.class;
	}

}
