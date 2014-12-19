package com.inspur.cams.sorg.check.somcheckauditopinion.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomCheckAuditOpinionDao
 * @description:
 * @author:
 * @since:2012-04-23
 * @version:1.0
*/
 public interface ISomCheckAuditOpinionDao extends BaseCURD<SomCheckAuditOpinion>{
	public void save(List<SomCheckAuditOpinion> list);
}

