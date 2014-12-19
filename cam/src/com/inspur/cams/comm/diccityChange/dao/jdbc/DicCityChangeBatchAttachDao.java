package com.inspur.cams.comm.diccityChange.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.comm.diccityChange.dao.IDicCityChangeBatchAttachDao;
import com.inspur.cams.comm.diccityChange.data.DicCityChangeBatchAttach;

/**
 * 区划变更上传附件表dao
 * @author 
 * @date 2014-01-13
 */
public class DicCityChangeBatchAttachDao extends EntityDao<DicCityChangeBatchAttach> implements IDicCityChangeBatchAttachDao {
	
	@Override
	public Class<DicCityChangeBatchAttach> getEntityClass() {
		return DicCityChangeBatchAttach.class;
	}

}