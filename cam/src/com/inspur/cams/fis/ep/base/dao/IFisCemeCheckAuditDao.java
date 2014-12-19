package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;

/**
 * @title:IFisCemeCheckAuditDao
 * @description:
 * @author:
 * @since:2011-11-28
 * @version:1.0
*/
 public interface IFisCemeCheckAuditDao extends BaseCURD<FisCemeCheckAudit>{
	public void save(List<FisCemeCheckAudit> list);
}

