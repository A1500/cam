package com.inspur.cams.bpt.excelToTable;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.persistent.util.domain.BaseJdbcDao;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.excelToTable.dao.MessageDao;
import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class ExcelToTableCommand extends BaseAjaxCommand{
	IBptGroupDomain service = ScaComponentFactory.getService(
			IBptGroupDomain.class, "bptGroupDomain/bptGroupDomain");
	
	protected static final Log logger = LogFactory.getLog(BaseJdbcDao.class);
	MessageDao dao = new MessageDao();
	/**
	 * 将临时表内容转换,验证加入make表
	 */
	@Trans
	public  void  execute(){
		
		String organ_code=(String) getParameter("organCode");
		String classPath =ExcelToTableCommand.class.getClassLoader().getResource("/").getPath();
		String rootPath="";
		String fileName="";
		String enumsfile="";
		 //windows下
		  if("\\".equals(File.separator)){   
		   ///rootPath  = classPath.substring(0,classPath.indexOf("/WEB-INF/classes")+1);
		  // System.out.println(rootPath+"!!!!!!!");
		   fileName=(classPath+(String) getParameter("xmlPath"));
		   enumsfile= (classPath+(String) getParameter("enumsPath"));
		  }
		  //linux下
		  if("/".equals(File.separator)){   
		   //rootPath  = classPath.substring(0,classPath.indexOf("/WEB-INF/classes"));
		   fileName=(classPath+(String) getParameter("xmlPath")).replace("\\", "/");
			enumsfile= (classPath+(String) getParameter("enumsPath")).replace("\\", "/");
		  }
		InputStream is=null;
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		
		UploadFile uploadfile = wrapRequest.getUploadFile("excel");
		 
		try {
			is=uploadfile.getInputStream();
			ReadXML xmldao = new ReadXML();//读xml 写入ToTable
			ToTable toTable=xmldao.parserXml(fileName);
			NewSQL sqldao = new NewSQL(toTable);//生成相关的sql语句
			
			ParseChange c = new ParseChange();//读枚举文件 为转换代码准备
			Map map =c.getEnumsMap(enumsfile);
			
			ReadExcel exceldao = new ReadExcel(sqldao,toTable,map);//读excel 插入到临时表
			String[] message=exceldao.readExcel(organ_code,is);
			
			
			
			/*InsertMakTable insertmakdao= new InsertMakTable(sqldao,toTable,map);//转换代码 验证信息 插入到make表
			String[] message=insertmakdao.insert(organ_code);*/
			
			System.out.println("共转换"+message[0]+"条数据,成功"+message[1]+"条,失败"+message[2]+"条.");
			System.out.println("---完毕---");
			
			
			String msg=message[0]+";"+message[1]+";"+message[2]+";"+message[3]+";"+message[4]+";"+message[5];
			super.setReturn("msg", msg);
			
		}catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("Excel_Error",e);
			e.printStackTrace();
		}finally{
			if(is!=null){
				try {
					is.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					logger.error("Excel_Error",e);
					e.printStackTrace();
				}
			}
			
		}
		
		
		
		
	}
	/**
	 * 更新伤残make表
	 * @param ds
	 * @return
	 */
	public void updateDisabilityMakeTable(){
		Record r=(Record)this.getParameter("record");
		String makeTable=(String)this.getParameter("makeTable");
		dao.updateDisabilityMakeTable(makeTable,r);
	}
	
	public void idCardIsSame(){
		String idcard=(String)this.getParameter("idCard");
		boolean b=dao.idCardIsSame(idcard);
		this.setReturn("isSame", b);
	}
	
	public void deleteById(){
		Record[] r=(Record[])this.getParameter("ErrRecords");
		String makeTable=(String)this.getParameter("makeTable");
		for (Record record : r) {
			String id=(String)record.get("ID");
			dao.deleteById(makeTable, id);
		}
		
	}
}
