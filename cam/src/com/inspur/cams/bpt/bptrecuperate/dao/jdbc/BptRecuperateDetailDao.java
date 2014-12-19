package com.inspur.cams.bpt.bptrecuperate.dao.jdbc;

import java.sql.Types;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.bptrecuperate.dao.IBptRecuperateDetailDao;
import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperateDetail;

/**
 * @title:BptRecuperateDetalDao
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
 */
public class BptRecuperateDetailDao extends EntityDao<BptRecuperateDetail> implements IBptRecuperateDetailDao {

    public BptRecuperateDetailDao() throws Exception {
        this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
        this.afterPropertiesSet();
    }

    @SuppressWarnings("unchecked")
    @Override
    public Class getEntityClass() {
        return BptRecuperateDetail.class;
    }



    public void deleteByBatchId(String[] batchId) {
        for (String id : batchId) {
            executeUpdate("delete from bpt_recuperate_detal t where t.BATCH_ID = ?", new int[] { Types.VARCHAR },
                    new Object[] { id });
        }

    }

    public DataSet selectByBatchId(ParameterSet pset) {
        String batchId = (String) pset.getParameter("batchId");
        return this.executeDataset(" select * from bpt_recuperate_detal t where t.BATCH_ID =?",
                new int[] { Types.VARCHAR }, new Object[] { batchId }, pset.getPageStart(), pset.getPageLimit(), true);
    }
    
    /**
     * 通过生日获取年龄
     */
    public DataSet queryAgeByBirthday(ParameterSet pset){
    	String birthday = (String)pset.getParameter("birthday"); 
    	String sql = "SELECT GETAGE(?) AS AGE FROM DUAL";
    	return this.executeDataset(sql, new int[]{Types.VARCHAR},new Object[]{birthday},true);
    }

}
