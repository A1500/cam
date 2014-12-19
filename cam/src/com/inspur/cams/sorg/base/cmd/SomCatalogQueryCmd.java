package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomCatalogDomain;

/**
 * 社会组织档案目录树查询cmd
 * @author Muqi
 * @date 2011-7-21
 */
public class SomCatalogQueryCmd extends BaseQueryCommand {
	
	// 获取SCA组件
	private ISomCatalogDomain somCatalogDomain = ScaComponentFactory.getService(ISomCatalogDomain.class, "somCatalogDomain/somCatalogDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "CATALOG_ORDER");
		pset.setParameter("dir", "asc");
		String catalogCode = (String) pset.getParameter("CATALOG_CODE@=");
		DataSet ds = somCatalogDomain.query(pset);
		if (catalogCode != null && ds.getCount() == 1) {
			Record record = ds.getRecord(0);
			record.set("catalogName", "");
			record.set("catalogCode", "");
			record.set("upCatalogCode", catalogCode);
			record.set("ifValid", "1");
			record.set("archiveStage", "0");
			record.set("fileCode", "");
			record.set("relatingFileCode", "");
			ParameterSet p = new ParameterSet();
			p.setParameter("UP_CATALOG_CODE", catalogCode);
			DataSet dset = somCatalogDomain.query(p);
			record.set("catalogOrder", dset.getCount() + 1);
		}
		ds.getMetaData().setIdProperty("CATALOG_CODE");
		return ds;
	}

}
