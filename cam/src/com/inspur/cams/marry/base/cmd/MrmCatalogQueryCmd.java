package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmCatalogDomain;

/**
 * 婚姻档案目录树查询cmd
 */
public class MrmCatalogQueryCmd extends BaseQueryCommand {
	
	// 获取SCA组件
	private IMrmCatalogDomain mrmCatalogDomain = ScaComponentFactory.getService(IMrmCatalogDomain.class, "mrmCatalogDomain/mrmCatalogDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		pset.setParameter("sort", "CATALOG_ORDER");
		pset.setParameter("dir", "asc");
		String catalogCode = (String) pset.getParameter("CATALOG_CODE@=");
		DataSet ds = mrmCatalogDomain.query(pset);
		if (catalogCode != null && ds.getCount() == 1) {
			Record record = ds.getRecord(0);
			record.set("catalogName", "");
			record.set("catalogCode", "");
			record.set("upCatalogCode", catalogCode);
			record.set("ifValid", "1");
			record.set("fileCode", "");
			ParameterSet p = new ParameterSet();
			p.setParameter("UP_CATALOG_CODE", catalogCode);
			DataSet dset = mrmCatalogDomain.query(p);
			record.set("catalogOrder", dset.getCount() + 1);
		}
		ds.getMetaData().setIdProperty("CATALOG_CODE");
		return ds;
	}

}
