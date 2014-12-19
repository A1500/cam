package com.inspur.cams.fis.base.dao.jdbc;

import java.util.List;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.fis.base.dao.IFisResourceExtendDao;
import com.inspur.cams.fis.base.data.FisResourceExtend;

/**
 * 墓位特征扩展表dao
 * 
 * @author
 * @date Fri Apr 13 09:45:56 GMT+08:00 2012
 */
public class FisResourceExtendDao extends EntityDao<FisResourceExtend> implements IFisResourceExtendDao {

	@Override
	public Class<FisResourceExtend> getEntityClass() {
		return FisResourceExtend.class;
	}
}