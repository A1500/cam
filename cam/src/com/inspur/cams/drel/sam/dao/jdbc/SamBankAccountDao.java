package com.inspur.cams.drel.sam.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.sam.dao.ISamBankAccountDao;
import com.inspur.cams.drel.sam.data.SamBankAccount;

/**
 * @title:SamBankAccountDao
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
 public class SamBankAccountDao extends EntityDao<SamBankAccount> implements ISamBankAccountDao{

 	public SamBankAccountDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamBankAccount.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamBankAccount");
	}

	public void deleteAccount(String familyId) {
		if(familyId != null && !("".equals(familyId.trim()))){
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM SAM_BANK_ACCOUNT WHERE FAMILY_ID= ?");
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { familyId };
			executeUpdate(sql.toString(), types, args);
		}
		
	}
}
