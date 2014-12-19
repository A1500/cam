package com.inspur.cams.sorg.jxcheck.somjxcheckauditopinion.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckAuditOpinionDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckAuditOpinionDao extends BaseCURD<SomJxCheckAuditOpinion>{
	public void save(List<SomJxCheckAuditOpinion> list);
}

