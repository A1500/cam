package com.inspur.cams.bpt.excelToTable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.bpt.excelToTable.data.FieldValidate;
import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.excelToTable.data.ToTableChange;
import com.inspur.cams.bpt.excelToTable.data.ToTableField;
public class ReadXML {
	protected static final Log logger = LogFactory.getLog(BaseJdbcDao.class);
	 /**
     * 读取xml文件
     * @param fileName
     */ 
    public ToTable parserXml(String fileName){    
        
        
        /*File inputXml=new File(fileName);  
        SAXReader saxReader = new SAXReader(); */   
        ToTable toTable = new ToTable();
        Document document;
        Element totable;
		
		try {
			InputStream ifile = new FileInputStream(fileName);
			InputStreamReader ir = new InputStreamReader(ifile, "UTF-8");
			SAXReader reader = new SAXReader(); 
			document = reader.read(ir);
			
			
			//document = saxReader.read(inputXml);
			totable=document.getRootElement();   //获取文档根节点 
            for(Iterator a = totable.attributeIterator();a.hasNext();){//取出临时,校验,业务表名 校验类,转换类               
                Attribute item = (Attribute)a.next(); 
                if("name".equals(item.getName())){
                	toTable.setTableName(item.getValue());
                }
                if("makeName".equals(item.getName())){
                	toTable.setMakeTableName(item.getValue());
                }
                if("tempName".equals(item.getName())){
                	toTable.setTempTableName(item.getValue());
                }
                if("vailClass".equals(item.getName())){
                	toTable.setVailClass(item.getValue());
                }
                if("changeClass".equals(item.getName())){
                	toTable.setChangeClass(item.getValue());
                }
                
            } 
            List fieldlist = new ArrayList();
            for(Iterator i = totable.elementIterator(); i.hasNext();){ //获取 字段  
            	ToTableField toTableField = new ToTableField();
            	Element fleld = (Element) i.next();
              for(Iterator m = fleld.attributeIterator();m.hasNext();){//获取 取的字段名称                
                  Attribute item = (Attribute)m.next(); 
                  if("name".equals(item.getName())){
                	  toTableField.setFieldName(item.getValue());
                  }
              } 
              List vaillist = new ArrayList();
              List changelist = new ArrayList();
              for(Iterator j = fleld.elementIterator(); j.hasNext();){  //获取校验 及转换
            	 
                  Element node=(Element) j.next();  
                  if("vaildate".equals(node.getName())){
                	  for(Iterator m = node.attributeIterator();m.hasNext();) //获取校验值
                      {                
                    	  FieldValidate fieldValidate = new FieldValidate();
                          Attribute item = (Attribute)m.next(); 
                          if("name".equals(item.getName())){
                        	  fieldValidate.setName(item.getValue());
                          }
                          vaillist.add(fieldValidate);
                      } 
                  }
                  if("change".equals(node.getName())){
                	  for(Iterator m = node.attributeIterator();m.hasNext();) //获取校验值
                      {                
                		  ToTableChange toTableChange = new ToTableChange();
                          Attribute item = (Attribute)m.next(); 
                          if("name".equals(item.getName())){
                        	  toTableChange.setName(item.getValue());
                          }
                          changelist.add(toTableChange);
                      } 
                  }
                  
              } 
              toTableField.setChangeList(changelist);
              toTableField.setFieldValiList(vaillist);
              fieldlist.add(toTableField);
             
           }
            toTable.setFieldList(fieldlist);
            
		} catch (DocumentException e1) {
				// TODO Auto-generated catch block
			logger.error("Excel_Error",e1);
				e1.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
        return toTable;
            
    }    
     
     
     
    public static void main(String[] args) { 
    	ReadXML demo = new ReadXML(); 
    	ToTable tt= demo.parserXml("e:/1.xml"); 
    	System.out.println(tt.getChangeClass());
    	
    } 
    
    public static ToTable parserXmlUtil(String fileName) {
    	return new ReadXML().parserXml(fileName);
    }


}
